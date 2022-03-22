#cloud-config
  
runcmd:
  # Enable and bring up vnc  
  - echo ${odi_vnc_password} | vncpasswd -f > /home/opc/.vnc/passwd
  - chmod 0600 /home/opc/.vnc/passwd
  - su opc
  - systemctl enable vncodi.service
  - systemctl start vncodi.service  
  - sudo cp /usr/share/applications/odi.desktop /home/opc/Desktop
  - sudo chown opc:opc /home/opc/Desktop/odi.desktop
  - chmod +rwx /home/opc/Desktop/odi.desktop
  
  # Create the adw properties file
  - echo adwInstanceOcId=${adw_instance} > /home/opc/odi-standalone-studio.properties
  - echo adwInstancePassword=${adw_password} >> /home/opc/odi-standalone-studio.properties
  - echo odiSchemaPrefix=${odi_schema_prefix} >> /home/opc/odi-standalone-studio.properties
  - echo odiSchemaPassword=${odi_schema_password} >> /home/opc/odi-standalone-studio.properties
  - echo odiSupervisorPassword=${odi_password} >> /home/opc/odi-standalone-studio.properties
  - echo rcuCreationMode=${adw_creation_mode} >> /home/opc/odi-standalone-studio.properties   
  - echo export JAVA_HOME=/home/opc/jdk1.8.0_191 >> /home/opc/.bashrc
  - echo export PATH=/home/opc/jdk1.8.0_191/bin:$PATH >> /home/opc/.bashrc 
  - mv /home/opc/odi-standalone-studio.properties /home/opc/oracle/odi/common/scripts
  - chown opc:opc /home/opc/oracle/odi/common/scripts/odi-standalone-studio.properties
  - echo export JAVA_HOME=/home/opc/jdk1.8.0_191; > /home/opc/configureRepo.sh
  - echo export PATH=/home/opc/jdk1.8.0_191/bin:$PATH; >> /home/opc/configureRepo.sh
  - echo if ${embedded_db} >> /home/opc/configureRepo.sh 
  - echo "then " >> /home/opc/configureRepo.sh 
  - echo "python /home/opc/oracle/odi/common/scripts/odiConfiguration.py python mysqlConnectorFilePath=/home/opc/mysql-connector-python-2.1.8.zip mysqlInstallerFilePath=/home/opc/mysql-5.7.26-linux-glibc2.12-x86_64.tar.gz mysqlInstallationDir=/home/opc; systemctl start mysqlodi.service" >> /home/opc/configureRepo.sh
  - echo "else " >> /home/opc/configureRepo.sh 
  - echo "python odiADWConfiguration.py;" >> /home/opc/configureRepo.sh
  - echo "fi" >> /home/opc/configureRepo.sh
  - echo "python startAgent.py /home/opc/oracle" >> /home/opc/configureRepo.sh  
  - echo "cd /home/opc" >> /home/opc/configureRepo.sh  
  - echo "rm mysql-5.7.26-linux-glibc2.12-x86_64.tar.gz mysql-connector-python-2.1.8.zip" >> /home/opc/configureRepo.sh  
  - mv /home/opc/configureRepo.sh /home/opc/oracle/odi/common/scripts
  - chown opc:opc /home/opc/oracle/odi/common/scripts/configureRepo.sh
  - chmod +rwx /home/opc/oracle/odi/common/scripts/configureRepo.sh
  - chmod +rwx /home/opc/oracle/odi/common/scripts/configureADBInstances.sh
  - cd /home/opc/oracle/odi/common/scripts 
  - rm -rf /home/opc/inventory_odi
  - mkdir -p /home/opc/inventory_odi/ContentsXML
  - echo "<INVENTORY>" > /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "   <VERSION_INFO>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "      <SAVED_WITH>13.9.4.0.0</SAVED_WITH>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "      <MINIMUM_VER>2.1.0.6.0</MINIMUM_VER>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "   </VERSION_INFO>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "   <HOME_LIST>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "      <HOME NAME='OracleHome99' LOC='/home/opc/oracle' TYPE='O' IDX='99'/>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "   </HOME_LIST>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "   <COMPOSITEHOME_LIST/>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "</INVENTORY>" >> /home/opc/inventory_odi/ContentsXML/inventory.xml
  - echo "inventory_loc=/home/opc/inventory_odi" >  /home/opc/tmp.loc
  - echo "inst_group=g682" >> /home/opc/tmp.loc
  - cp /home/opc/tmp.loc /home/opc/oracle/oraInst.loc
  - echo "JAVA_HOME=/home/opc/jdk1.8.0_191" > /home/opc/oracle/oui/.globalEnv.properties
  - echo "JAVA_HOME_1_8=/home/opc/jdk1.8.0_191" >> /home/opc/oracle/oui/.globalEnv.properties
  - export ORACLE_HOME=/home/opc/oracle  
  - chown -R opc:opc /home/opc/inventory_odi
  - su opc -c "export JAVA_HOME=/home/opc/jdk1.8.0_191; export PATH=/home/opc/jdk1.8.0_191/bin:$PATH; ./configureRepo.sh" > /home/opc/logs/odiConfigure.log      
 
final_message: "The system is finally up, after $UPTIME seconds"
  