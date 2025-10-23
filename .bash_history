wget https://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
sudo tar -xzf apache-maven-3.5.2-bin.tar.gz -C /opt
echo "export PATH=/opt/apache-maven-3.5.2/bin:$PATH" >> ~/.bashrc
source ~/.bashrc
ls
ls -l
pwd
mvn --version
sudo dnf install -y java-1.8.0-amazon-corretto-devel
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64
export PATH=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre/bin/:$PATH
ls
mvn -v
mvn --version
java -version
mvn archetype:generate    -DgroupId=com.nextwork.app    -DartifactId=nextwork-web-project    -DarchetypeArtifactId=maven-archetype-webapp    -DinteractiveMode=false
pwd
ls
cd nextwork-web-project/
ls
cd src/
ls
cd main/
ls
cd webapp/
ls
cat index.jsp 
cd w
cd WEB-INF/
ls
cd
ls
cd /home/ec2-user/nextwork-web-project
ls
cd nextwork-web-project/
ls
cd src/
ls
cd main/
ls
cd webapp/
ls
ec2-15-237-190-83.eu-west-3.compute.amazonaws.comec2-15-237-190-83.eu-west-3.compute.amazonaws.comec2-15-237-190-83.eu-west-3.compute.amazonaws.com
cls
clear
