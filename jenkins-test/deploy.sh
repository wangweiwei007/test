#!/usr/bin/env bash
#编译+部署jenkins-test站点

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

### base 函数
killTomcat()
{
    pid=`ps -ef|grep tomcat|grep java|awk '{print $2}'`
    echo "tomcat Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no tomcat pid alive"
    else
      kill -9 $pid
    fi
}
cd $PROJ_PATH/jenkins-test
mvn clean install -Dmaven.test.skip=true

# 停tomcat
killTomcat

#备份原有工程
cp $TOMCAT_APP_PATH/webapps/jenkins-test.war  $TOMCAT_APP_PATH/backup/jenkins-test.war.`date +%Y%m%d%H%M`

# 删除原有工程
rm -rf $TOMCAT_APP_PATH/webapps/*

# 复制新的工程
cp $PROJ_PATH/jenkins-test/target/jenkins-test-0.0.1-SNAPSHOT.war $TOMCAT_APP_PATH/webapps/

cd $TOMCAT_APP_PATH/webapps/
mv jenkins-test-0.0.1-SNAPSHOT.war jenkins-test.war

# 启动Tomcat
cd $TOMCAT_APP_PATH/
sh bin/startup.sh



