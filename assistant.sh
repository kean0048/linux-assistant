#!/bin/bash
sudo apt install -y xterm
sudo apt install -y zenity
resize -s 45 90
SELECT=$(whiptail --title "Linux助手" --checklist \
"选择要安装的软件或电脑配置（可多选，空格键选择，Tab键跳转)" 45 90 37 \
"CUDA 9.1" "Ubuntu18 仓库提供" OFF \
"CUDA 10.1, cudnn 7.6.5" "仅限于Ubuntu18" OFF \
"CAJViewer" "知网文献阅读器" OFF \
"FBReader" "Linux电子书阅读器，支持epub等格式" OFF \
"Google Chrome" "市占率最高的浏览器" OFF \
"Gnome Tweak Tool" "Ubuntu18设置软件" OFF \
"Miniconda3" "Python虚拟环境管理器" OFF \
"mendeley" "文献管理软件" OFF \
"NVIDIA显卡驱动" "    安装此项后安装CUDA时就不需选择Driver了" OFF \
"proxychains" "代理流量软件" OFF \
"PyCharm Community" "Python IDE，功能强大" OFF \
"QQ" "Linux版QQ" OFF \
"Qv2ray" "v2ray代理软件" OFF \
"RoboWare" "ROS开发IDE" OFF \
"RedShift-GTK" "护眼软件，可根据时间自动调节色温" OFF \
"Simple Screen Recorder" "Linux优秀录屏软件" OFF \
"Terminator" "可一窗口多开的终端模拟器" OFF \
"tmux" "终端复用软件，尤其对于SSH连接服务器情况" OFF \
"TeamViewer" "远程协助软件" OFF \
"VirtualBox" "虚拟机软件" OFF \
"VMWare Pro 16" "虚拟机软件，功能强大" OFF \
"VSCode" "代码编辑器，功能强大、易用" OFF \
"VLC" "媒体播放器" OFF \
"Vim 8.2" "编译源码添加python2,支持YouCompleteme插件" OFF \
"WPS" "Linux版WPS" OFF \
"百度网盘" "    Linux版百度网盘" OFF \
"搜狗拼音输入法" "       Linux版搜狗拼音输入法" OFF \
"向日葵远控" "     国产远程协助软件，更加易用" OFF \
"psensor" "温度监控软件" OFF \
"~~~~~~~~~~~~~~~~~~~~~~~~~~" "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" OFF \
"conda,pip设置国内源" "     可显著提供conda/pip install 速度" OFF \
"git设置socks5代理" "    可显著提高git clone速度" OFF \
"git取消代理" "    删除代理设置" OFF \
"git push记住用户名和密码" "      使用https方式不用每次输入密码和用户名" OFF \
"Ubuntu18再次点击图标最小化" "    再次点击图标时会最小化窗口" OFF \
"Ubuntu18取消再次点击图标最小化" "恢复默认，再次点击图标没有反应" OFF \
"Ubuntu18 换国内源"   "    可显著提高终端联网指令的网速" OFF \
3>&1 1>&2 2>&3
)


Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White


Flag_Doc=0        # 0 stands for no need of a doc, 1 otherwise.

# to determine os language
if [ -d "${HOME}/Desktop" ]
then
    FileLocation="${HOME}/Desktop/Ubuntu助手附加说明.txt"
else
    FileLocation="${HOME}/桌面/Ubuntu助手附加说明.txt"
fi


touch_check() {
    cd ~/Desktop || cd ~/桌面
    if [ ! -f "Ubuntu助手附加说明.txt" ];then
        touch ~/Desktop/Ubuntu助手附加说明.txt || touch ~/桌面/Ubuntu助手附加说明.txt
    fi
}

echo_out() {
    echo "$1" >> ~/Desktop/Ubuntu助手附加说明.txt || echo "$1" >> ~/桌面/Ubuntu助手附加说明.txt
}

function success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}安装成功！${Color_Off}"
}

function keep {
	sleep 1s
}

function config_success {
	# if you want to use colored font display, must add -e parameter.
	echo -e "${BGreen}配置成功！${Color_Off}"
}

through_git_deb() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.deb" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi

    cd ~/linux-assistant/$1-package
    sudo dpkg -i $1.deb
    sudo apt -f install
    sudo apt -f install
    success
    rm -rf ~/linux-assistant/$1-package
}

through_git_sh() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.sh" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi

    cd ~/linux-assistant/$1-package
    chmod a+x $1.sh
    ./$1.sh
    rm -rf ~/linux-assistant/$1-package
}

through_git_appimage() {
    echo -e "${BGreen}将要安装$1 ${Color_Off}" && sleep 1s
	sudo apt install -y git

    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/$1-package"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/$1-package" ];then
            git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.sh" ];then
        git clone https://gitee.com/borninfreedom/$1-package.git ~/linux-assistant/$1-package
    fi

    cd ~/linux-assistant/$1-package
    cp $1.AppImage ~/Desktop || cp $1.AppImage ~/桌面
    cd ~/Desktop || cd ~/桌面
    chmod a+x $1.AppImage
    echo -e "${BGreen}Please double click the $1.AppImage to launch it on the Desktop.${Color_Off}"
    rm -rf ~/linux-assistant/$1-package
}

Vim() {
#	sudo add-apt-repository ppa:jonathonf/vim	
#	sudo apt update
#	sudo apt install -y vim
	#sudo apt install -y vim-gtk3 vim-nox

	sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev python-dev python3-dev git ctags cscope
	sudo apt remove -y vim vim-runtime gvim
	cd 
	git clone https://gitee.com/borninfreedom/vim.git && sudo mv vim /usr
	cd /usr/vim
	sudo ./configure --with-features=huge  --enable-multibyte  --enable-pythoninterp=yes  --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/  --enable-python3interp=yes  --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/  --enable-gui=gtk2  --enable-cscope  --prefix=/usr/local/
	sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
	sudo make install
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
	sudo update-alternatives --set editor /usr/local/bin/vim
	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
	sudo update-alternatives --set vi /usr/local/bin/vim
	vim --version

    #add vim plug
    sudo apt install curl
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    #add vim vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    echo -e "${BGreen}安装成功！${Color_Off}"

}

tmux() {
    sudo apt install -y tmux || \
    sudo apt install -y tmux || \
    sudo apt install -y tmux && \
    mv ~/.tmux.conf ~/.tmux.conf.bak 

    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    
    touch $fileLocation 
    echo "【tmux】" >> $fileLocation
    echo "tmux除了将软件安装之外，还自动进行了配置，配置文件说明请浏览网站https://github.com/gpakosz/.tmux" >> $fileLocation
    echo "如果不想使用已经配置好的配合文件，而是想要一个纯净的tmux配置环境，请执行 mv ~/.tmux.conf.bak ~/.tmux.conf" >> $fileLocation
    echo "如果想再次使用此较为完善的配置文件，请重新运行本软件，再次安装tmux即可。" >> $fileLocation

    Flag_Doc=1
    echo -e "${BGreen}安装成功！${Color_Off}"
}

fbreader() {
    sudo apt install -y fbreader || sudo apt install -y fbreader || sudo apt install -y fbreader 
    echo -e "${BGreen}安装成功！${Color_Off}"
}
function proxychains {
	echo -e "${BYellow}将要安装proxychains。${Color_Off}" && sleep 1s
	cd ~
	sudo apt install -y gcc git vim cmake
	git clone https://github.com/rofl0r/proxychains-ng.git ~/linux-assistant/proxychains-ng
	cd ~/linux-assistant/proxychains-ng
	./configure
	sudo make && sudo make install
	sudo cp ./src/proxychains.conf /etc/proxychains.conf
    touch_check
    echo_out "【proxychains】"
    echo_out "请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。"
	#echo -e "${BRed}请执行 sudo vi /etc/proxychains.conf ，将最后的 socks4 127.0.0.1 9095 改为 socks5 127.0.0.1 1089 ，其中 1089是qv2ray 6.0 版本 socks5 代理默认的开放端口，如果不确定自己的端口号，请查看后再输入。${Color_Off}"
    rm -rf ~/linux-assistant/proxychains-ng
}

function redshift {		# the former of { must have a space
	echo -e "${BGreen}Install redshift${Color_Off}" && sleep 1s \
	# -y parameter indicates that you auto select yes.
	sudo apt install -y redshift-gtk
	echo ' ' | sudo tee -a /etc/geoclue/geoclue.conf
	echo '[redshift]' | sudo tee -a /etc/geoclue/geoclue.conf
	echo 'allowed=true' | sudo tee -a /etc/geoclue/geoclue.conf
	echo 'system=false' | sudo tee -a /etc/geoclue/geoclue.conf
	echo 'users=' | sudo tee -a /etc/geoclue/geoclue.conf
        echo -e "${BGreen}安装成功！${Color_Off}"


	# when you exec a command, shell will return a flag that indicates whether exec successfully. if success ,return 0, otherwise 1 default. you can use
	# $? to extract the flag.
	# the role of && is  if $?==0, then exec next cmd.
	# the role of || is, if $?!=0, then exec next cmd.
}

function terminator {
	echo -e "${BGreen}将要安装terminator${Color_Off}" \
	&& sleep 1s \
	&& sudo apt install -y terminator \
	&& echo -e "${BGreen}安装成功"
}

function wps {
	echo -e "${BYellow}将要安装WPS${Color_Off}" && sleep 1s \
	&& sudo apt install -y git \
    && cd ~ \
    && git clone https://gitee.com/borninfreedom/wps-packages.git  ~/linux-assistant/wps-packages\
    && cd ~/linux-assistant/wps-packages \
    && sudo dpkg -i wps.deb \
    && sudo apt -f install \
    &&  success \
    && rm -rf wps-packages
}

function vscode {
    echo -e "${BGreen}将要安装VSCode${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~
    git clone https://gitee.com/borninfreedom/vscode-packages.git
    cd vscode-packages
    sudo dpkg -i vscode.deb
    sudo apt -f install
    success
    cd ~/linux-assistant
    rm -rf vscode-packages
}

function chrome {
    echo -e "${BYellow}将要安装Google Chrome${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~
    git clone https://gitee.com/borninfreedom/chrome-package.git ~/linux-assistant/chrome-package
    cd ~/linux-assistant/chrome-package
    sudo dpkg -i chrome.deb
    sudo apt -f install
    success
    cd ~/linux-assistant
    rm -rf chrome-package
}

function mendeley {
    echo -e "${BGreen}将要安装mendeley文献管理软件${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~
    git clone https://gitee.com/borninfreedom/mendeley-package.git ~/linux-assistant/mendeley-package
    cd ~/linux-assistant/mendeley-package
    sudo dpkg -i mendeley.deb
    sudo apt -f install
    success
    rm -rf ~/linux-assistant/mendeley-package
}


function teamviewer {
    echo -e "${BYellow}将要安装TeamViewer${Color_Off}" && sleep 1s 
	sudo apt install -y git 
    cd ~ 
    git clone https://gitee.com/borninfreedom/teamviewer-package.git ~/linux-assistant/teamviewer-package
    cd ~/linux-assistant/teamviewer-package 
    sudo dpkg -i teamviewer.deb 
    sudo apt -f install 
    sudo apt -f install
    success 
    rm -rf teamviewer-package
}

function qq {
    echo -e "${BGreen}将要安装QQ${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~

    FOLDER="${HOME}/linux-assistant/qq-package"
    if [ ! -d "$FOLDER" ]; then
         git clone https://gitee.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    else
        [ ! -f "${FOLDER}/qq.deb" ] \
        && rm -rf "${FOLDER}" \
        &&  git clone https://gitlab.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    fi

    #git clone https://gitlab.com/borninfreedom/qq-package.git ~/linux-assistant/qq-package
    cd ~/linux-assistant/qq-package
    sudo dpkg -i qq.deb
    sudo apt -f install
    success
    cd ~/linux-assistant
    rm -rf qq-package
}


function xiangrikui {
    echo -e "${BGreen}将要安装向日葵远控${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~

    FOLDER="${HOME}/linux-assistant/xiangrikui-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    else
        [ ! -f "${FOLDER}/xiangrikui.deb" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    fi

   # git clone https://gitee.com/borninfreedom/xiangrikui-package.git ~/linux-assistant/xiangrikui-package
    cd ~/linux-assistant/xiangrikui-package
    sudo dpkg -i xiangrikui.deb
    sudo apt -f install
    sudo apt -f install
    success
    rm -rf ~/linux-assistant/xiangrikui-package
}

function pycharm-cmu {
    echo -e "${BGreen}将要安装PyCharm-Community,git代理可能会影响下载。安装包较大，请耐心等待！${Color_Off}" && sleep 1s
	sudo apt install -y git
    cd ~
    ROOT_DIR="${HOME}/linux-assistant"
    FILE_DIR="$ROOT_DIR/pycharm-cmu-packages"

    if [ ! -d "$ROOT_DIR" ];then
        mkdir -p $ROOT_DIR
    else
        if [ ! -d "$ROOT_DIR/pycharm-cmu-packages" ];then
            git clone https://gitee.com/borninfreedom/pycharm-cmu-packages.git ~/linux-assistant/pycharm-cmu-packages
        fi
    fi

    cd $FILE_DIR
    if [ ! -f "$1.deb" ];then
        git clone https://gitee.com/borninfreedom/pycharm-cmu-packages.git ~/linux-assistant/pycharm-cmu-packages
    fi


    cd ~/linux-assistant/pycharm-cmu-packages
    tar -zxvf pycharm.tar.gz
    mv pycharm ~
    cd ~/pycharm/bin
    touch_check
    echo_out "【Pycharm】"
    echo_out "pycharm的安装包已经放到 ~/pycharm 路径。将pycharm图标添加到启动器，请参考https://blog.csdn.net/bornfree5511/article/details/103985989"
    ./pycharm.sh
}

function qv2ray {
    echo -e "${BGreen}将要安装Qv2ray${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~

    FOLDER="${HOME}/linux-assistant/qv2ray-packages"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitlab.com/borninfreedom/qv2ray-packages.git ~/linux-assistant/qv2ray-packages
    else
        [ ! -f "${FOLDER}/qv2ray.AppImage" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitlab.com/borninfreedom/qv2ray-packages.git ~/linux-assistant/qv2ray-packages
    fi


    cd ~/linux-assistant/qv2ray-packages
    unzip vcore.zip -d ~/vcore

    mv ~/linux-assistant/qv2ray-packages/qv2ray-instruction.pdf ~/Desktop  || mv ~/linux-assistant/qv2ray-packages/qv2ray-instruction.pdf ~/桌面
    mv ~/linux-assistant/qv2ray-packages/qv2ray.AppImage ~
    chmod a+x ~/qv2ray.AppImage
    touch_check
    echo_out "【Qv2ray】"
    echo_out "请新打开一个终端，运行 ./qv2ray.AppImage"
    echo_out "在你的桌面上有一个 qv2ray-instruction.pdf 文件，请阅读并按照配置。配置完成后，请关闭Qv2ray软件。"
    echo_out "然后运行  mv ~/vcore ~/.config/qv2ray"
    echo_out "登出（logout），重新登录用户，也可以直接重启。（qv2ray设置中如果勾选了‘开机启动’，重新登录后便会自动开启qv2ray）"

    rm -rf ~/linux-assistant/qv2ray-packages
}

function virtualbox {
    sudo apt install -y virtualbox
}

hpdriver() {
    echo -e "${BGreen} HP Printer Driver will be installed${Color_Off}"
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/hpdriver-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/hpdriver-package.git ~/linux-assistant/hpdriver-package
    else
        [ ! -f "${FOLDER}/hpdriver.run" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/hpdriver-package.git ~/linux-assistant/hpdriver-package
    fi

    cd ~/linux-assistant/hpdriver-package
    chmod a+x hpdriver.run
    sudo ./hpdriver.run
    rm -rf ~/linux-assistant/hpdriver-package
}

function gitproxy {
	read -p "请输入代理socks5代理端口，默认为1089，默认代理地址是127.0.0.1：" port
    #port=${port:1089}
	while ! [[ "$port" =~ ^[0-9]+$ ]]
	do
	# -n parameter indicates that do not jump to next line
	echo -e -n "${BRed}仅接受数字："
	read port
	done

	git config --global http.proxy socks5://127.0.0.1:${port} && git config --global https.proxy socks5://127.0.0.1:${port} && config_success
}

function gitpush_store_passwd {
    echo -e "${BRed}如果您的Gitee、GitHub、Gitlab不是同用户名、同密码，使用这项会造成上传错误！${Color_Off}"
    read -r -p "确认使用吗？[y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS][yY])$ ]];then
        git config --global credential.helper store && config_success
    else
        echo -e "${BRed}放弃配置此项${Color_Off}"
    fi

}

conda_pip_sources() {
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    config_success
    touch_check
    echo_out "【conda和pip源设置】"
    echo_out "若要修改配置文件，执行vi ~/.condarc，vi ~/.config/pip/pip.config"
}

gitproxy_cancel() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    config_success
}

selects() {
    echo $SELECT | grep "$1" && "$2"
}

vmware() {
    echo -e "${BGreen}将要安装VMWare Workstation Pro 16, 安装包较大，请耐心等待。${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/vmware-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/vmware-package.git ~/linux-assistant/vmware-package
    else
        [ ! -f "${FOLDER}/vmware.bundle" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/vmware-package.git ~/linux-assistant/vmware-package
    fi

    cd ~/linux-assistant/vmware-package
    chmod a+x vmware.bundle
    sudo ./vmware.bundle
    rm -rf ~/linux-assistant/vmware-package
    touch_check
    echo_out "【VMware注册码】"
    echo_out "ZF3R0-FHED2-M80TY-8QYGC-NPKYF"
    echo_out "YF390-0HF8P-M81RQ-2DXQE-M2UT6"
    echo_out "ZF71R-DMX85-08DQY-8YMNC-PPHV8"

}

cuda() {
    echo -e "${BGreen}将要安装cuda10.1 update2版本${Color_Off}"
    cd
    wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
    sudo sh cuda_10.1.243_418.87.00_linux.run
    success
    echo "export PATH=$PATH:/usr/local/cuda-10.1/" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.1/lib64" >> ~/.bashrc
    source ~/.bashrc
    #rm -rf ~/cuda_10.1.243_418.87.00_linux.run

    echo -e "${BGreen}将要安装cudnn7.6.5，安装包较大，请耐心等待。${Color_Off}"
    cd ~
    FOLDER="${HOME}/linux-assistant/cudnn7-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/cudnn7-package.git ~/linux-assistant/cudnn7-package
    else
        [ ! -f "${FOLDER}/cudnn.tgz" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/cudnn7-package.git ~/linux-assistant/cudnn7-package
    fi

    cd ~/linux-assistant/cudnn7-package
    tar -xzvf cudnn.tgz
    sudo cp ~/linux-assistant/cudnn7-package/cuda/include/cudnn*.h /usr/local/cuda/include
    sudo cp ~/linux-assistant/cudnn7-package/cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
    success
    rm -rf ~/linux-assistant/cudnn7-package
}

nvidia-driver() {
    echo -e "${BGreen}将要安装NVIDIA显卡驱动${Color_Off}"
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update
    sudo ubuntu-drivers autoinstall   # for recommended
    # sudo  apt install nvidia-driver-xxx  # for self-assignment
    success
    touch_check
    echo_out "【NVIDIA显卡驱动】"
    echo_out "请不要再更新内核，有可能导致显卡驱动失效。如果启动过程有任何问题，或者没有问题，也推荐按照此篇博客进行配置：https://blog.csdn.net/bornfree5511/article/details/109275982"
}

roboware() {
    echo -e "${BGreen}将要安装RoboWare Studio 和 RoboWare Viewer, 安装包较大，请耐心等待。${Color_Off}" && sleep 1s
    sudo apt install -y git
    cd ~
    FOLDER="${HOME}/linux-assistant/roboware-package"
    if [ ! -d "$FOLDER" ]; then
        git clone https://gitee.com/borninfreedom/roboware-package.git ~/linux-assistant/roboware-package
    else
        [ ! -f "${FOLDER}/roboware-studio*.deb" ] \
        && rm -rf "${FOLDER}" \
        && git clone https://gitee.com/borninfreedom/roboware-package.git ~/linux-assistant/roboware-package
    fi

    cd ~/linux-assistant/roboware-package
    sudo dpkg -i roboware-studio*.deb
    sudo apt -f install
    sudo apt -f install
    sudo dpkg -i roboware-viewer*.deb
    sudo apt -f install
    sudo apt -f install
    sudo mv RoboWare*.pdf ~/Desktop ||  sudo mv RoboWare*.pdf ~/桌面
    rm -rf ~/linux-assistant/roboware-package

    zenity --warning \
    --text="RoboWare软件的说明文档已经放到桌面。"

}


psensor() {
    echo -e "${BGreen}将要安装psensor${Color_Off}" && sleep 1s
    sudo apt install -y psensor
    success

}

demestic_sources() {
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo  touch /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list
    echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    echo "deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse"  | sudo tee -a  /etc/apt/sources.list
    sudo apt update

}
#################################################################################################################
existstatus=$?

if [ $existstatus = 0 ]; then
   # echo $SELECT | grep "7" && echo "test success"
    selects "psensor" psensor
    echo $SELECT | grep "VSCode" && vscode

    echo $SELECT | grep "RedShift-GTK" && redshift
    echo $SELECT | grep "WPS" && wps
    echo $SELECT | grep "Terminator" && terminator

    echo $SELECT | grep "TeamViewer" && teamviewer
    echo $SELECT | grep "向日葵远控" && xiangrikui
    echo $SELECT | grep "QQ" && qq
    echo $SELECT | grep "mendeley" && mendeley
    echo $SELECT | grep "VirtualBox" && virtualbox
    echo $SELECT | grep "Google Chrome" && chrome
    echo $SELECT | grep "Miniconda3" && through_git_sh miniconda
    echo $SELECT | grep "CAJViewer" && through_git_appimage cajviewer
    echo $SELECT | grep "Gnome Tweak Tool" && sudo apt install gnome-tweak-tool

   # selects 18 hpdriver


    echo $SELECT | grep "git push记住用户名和密码" && gitpush_store_passwd
    echo $SELECT | grep "conda,pip设置国内源" && conda_pip_sources
    echo $SELECT | grep "Ubuntu18再次点击图标最小化" && gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
    echo $SELECT | grep "Ubuntu18取消再次点击图标最小化" && gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'


    selects "git取消代理" gitproxy_cancel

    echo $SELECT | grep "proxychains" && proxychains
    selects "VMWare Pro 16" vmware
    echo $SELECT | grep "搜狗拼音输入法" && through_git_deb sogou && touch_check && echo_out "【搜狗拼音输入法】" && echo_out "请打开地区和语言设置->管理已安装语言->系统输入法框架，更改为fcitx，然后重启。重启后在输入法中添加搜狗，具体操作请参考：https://blog.csdn.net/lupengCSDN/article/details/80279177。只参考系统设置部分就可以，安装部分已经完成。"
    echo $SELECT | grep "百度网盘" && through_git_deb baidunetdisk
    

    selects "CUDA 10.1, cudnn 7.6.5" cuda
    echo $SELECT | grep "CUDA 9.1" && sudo apt -y install nvidia-cuda-toolkit
    selects "NVIDIA显卡驱动" nvidia-driver
    echo $SELECT | grep "Simple Screen Recorder" && sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder && sudo apt-get -y update && sudo apt-get -y install simplescreenrecorder
    echo $SELECT | grep "VLC" && sudo add-apt-repository ppa:videolan/master-daily && sudo apt-get -y update && sudo apt-get install -y vlc

    selects "RoboWare" roboware
    selects "Ubuntu18 换国内源" demestic_sources
	selects "Vim 8.2" Vim
    selects "tmux" tmux
    selects "FBReader" fbreader

    ##################################################
    # it's always at last. Otherwise there is a bug
    
    echo $SELECT | grep "Qv2ray" && qv2ray
    echo $SELECT | grep "PyCharm Community" && pycharm-cmu
    echo $SELECT | grep "git设置socks5代理" && gitproxy
    #####################################################
    
    if [ $Flag_Doc -eq 1 ]
    then 
        zenity --warning \
         --text="部分程序有一些额外说明，请阅读你的桌面上的【Ubuntu助手附加说明.txt】文件" 
    else
        echo -e "${BGreen}全部安装完成！${Color_Off}"
    fi


   
##################################################################################################################################

else
    echo "取消"
fi
