#!/bin/bash
#
# mailto: robbie.tang@yoyousoft.com
#
# scrtipname : start.sh
#

source /etc/profile

cd `dirname $0`
BIN_DIR=`pwd`

cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf


MAIN_CLASS=com.igaming.gs.GSServer

# 获取工程名
BIN_NAME=$(basename $DEPLOY_DIR)

SERVER_PORT=$(sed -n '/mina.port/p' $CONF_DIR/app.properties | grep -o "[0-9]\{1,\}")

# 判断程序是否启动
PIDS=`ps -f | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -n "$PIDS" ]; then
    echo "ERROR: The $BIN_NAME already started!"
    echo "$BIN_NAME PID : $PIDS "
    exit 1
fi

# 获取 jar_lib
LIB_DIR=$DEPLOY_DIR/lib
jar_lib=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`
# echo $jar_lib

# 日志输出文件
STDOUT_FILE=/dev/null 

# 启动程序
# [ -z "$jar_lib" ] && echo "ERROR: NO jar IN $LIB_DIR "  ||  
nohup java -Xdebug -Xrunjdwp:transport=dt_socket,address=9002,server=y,suspend=n -Xms1024m -Xmx1024m -Xmn800m -Xss256K -XX:PermSize=200M  -XX:MaxPermSize=200M  -XX:MaxTenuringThreshold=20 -XX:SurvivorRatio=2 -XX:+UseConcMarkSweepGC -XX:+PrintGCTimeStamps -XX:+PrintGC -XX:+PrintGCDetails -classpath $CONF_DIR:$jar_lib $MAIN_CLASS > $STDOUT_FILE 2>&1 &


# 监听启动过程
LISTEN_PORT=$SERVER_PORT
echo -e "Starting" "\033[31m [ $BIN_NAME ] \033[0m" 
echo -e -n "  " "checking port:" "\033[31m[ $LISTEN_PORT ]\033[0m .."

while true
do
{
	sleep 1
	GET_PORT_SIGN=$(netstat -tunl |grep -w "$LISTEN_PORT" |wc -l)
	[ "$GET_PORT_SIGN" -ne 1 ]  && echo -n "." || { echo -e "..\033[32m OK \033[0m" ; break ; }
}
done

sleep 3

# 启动完成，显示PID
PIDS=`ps -f | grep java | grep "$CONF_DIR" |awk '{print $2}'`
echo -e "  " "Running PID:" "\033[32m [ $PIDS ]\033[0m \n"


