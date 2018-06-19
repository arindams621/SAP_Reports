pipeline {
    agent any

stages{

stage('Checkout') {

steps{

	checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/arindams621/SAP_Reports.git']]])
	
	sh 'chmod +x ${WORKSPACE}/prep.sh'
	sh '${WORKSPACE}/prep.sh export.properties promote.properties'
	sh 'scp -pr ${WORKSPACE}/copy_artifacts.sh bouser@104.209.151.90:/usr/sap/BIP/sap_bobj/'
	sh 'scp -pr ${WORKSPACE}/export.properties bouser@104.209.151.90:/usr/sap/BIP/sap_bobj/'
	sh 'scp -pr ${WORKSPACE}/promote.properties bouser@104.209.151.216:/usr/sap/BIP/sap_bobj/'

	}
}


stage('Build') {

steps{

	sh '''
      ssh -o StrictHostKeyChecking=no -t bouser@104.209.151.90 /bin/bash "
      /usr/sap/BIP/sap_bobj/lcm_cli.sh -lcmproperty /usr/sap/BIP/sap_bobj/export.properties
      chmod +x /usr/sap/BIP/sap_bobj/copy_artifacts.sh
      /usr/sap/BIP/sap_bobj/copy_artifacts.sh
	   "
	  '''

	}
}


stage('Deploy') {

steps{

	sh '''
     ssh -o StrictHostKeyChecking=no -t bouser@104.209.151.216 /bin/bash "
		/usr/sap/BIP/sap_bobj/lcm_cli.sh -lcmproperty /usr/sap/BIP/sap_bobj/promote.properties
	    "
	  '''

	}
}

}
}
