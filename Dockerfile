FROM openjdk:11
EXPOSE 8089
ADD target/StudentManagement-jenkins-1.0.jar StudentManagement-jenkins.jar
ENTRYPOINT ["java", "-jar" ,  "StudentManagement-jenkins.jar"]
