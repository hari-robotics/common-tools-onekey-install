cleanup() {
    rm -rf "$HOME/.tmp_install"
    exit 1
}

trap cleanup SIGINT SIGTERM
trap cleanup EXIT

info() {
    echo -e "\033[1;32m[INFO]: $1\033[0m"
}

warn() {
    echo -e "\033[1;33m[WARNING]: $1\033[0m"
}

error() {
    echo -e "\033[1;31m[ERROR]: $1\033[0m" >&2
}

try_update_apt() {
    if sudo apt update > /dev/null 2>&1 & PID=$!
        while kill -0 $PID 2>/dev/null; do
            for c in / - \\ \|; do
                echo -ne "\rupdating apt source $c"
                sleep 0.1
            done
        done
    then
        echo " Done"
    else
        echo " Failed"
        error "apt source updating failed, please check your internet connection and try again."
        echo "Exiting..."
        exit 1
    fi
}

try_install() {
    local package="$1"
    local display_name="${2:-$package}"

    echo -ne "Trying to install $display_name: "
    if command -v "$package" >/dev/null 2>&1; then
        echo "$display_name is already installed."
        return 0
    fi

    sudo apt install -y "$package" > /dev/null 2>&1 &
    local pid=$!

    local spin='/-\|'
    while kill -0 "$pid" 2>/dev/null; do
        for (( i=0; i<${#spin}; i++ )); do
            echo -ne "\rInstalling $display_name ${spin:$i:1}"
            sleep 0.1
        done
    done

    wait "$pid"  # 等待安装进程完成

    if [ $? -eq 0 ]; then
        echo -e " Installed"
    else
        echo -e " Failed"
        error "Installation failed. Please install $display_name manually."
        exit 1
    fi
}

try_add_apt_repository() {
    local repository="$1"
    local display_name="${2:-$repository}"

    sudo add-apt-repository -y "$repository" > /dev/null 2>&1 &
    local pid=$!

    local spin='/-\|'
    while kill -0 "$pid" 2>/dev/null; do
        for (( i=0; i<${#spin}; i++ )); do
            echo -ne "\rAdding $display_name to apt repository ${spin:$i:1}"
            sleep 0.1
        done
    done

    wait "$pid"  # 等待安装进程完成

    if [ $? -eq 0 ]; then
        echo -e " Added"
    else
        echo -e " Failed"
        error "Adding repository failed. Please try adding $display_name manually."
        exit 1
    fi
}