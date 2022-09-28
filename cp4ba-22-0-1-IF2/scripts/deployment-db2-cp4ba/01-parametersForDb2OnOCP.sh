#!/bin/bash
# set -x
###############################################################################
#
# Licensed Materials - Property of IBM
#
# (C) Copyright IBM Corp. 2022. All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#
###############################################################################

echo "  Reading 01-parametersForDb2OnOCP.sh ..."

# ----------------------------------------------
# --- Parameters that usually need an update ---
# ----------------------------------------------

# --- Provide those BEFORE running script 02-createDb2OnOCP.sh ---

# Selected CP4BA template to use for deployment, for example ibm_cp4a_cr_template.100.ent.ClientOnboardingDemo.yaml
#   Available templates:
#     ibm_cp4a_cr_template.001.ent.Foundation.yaml
#     ibm_cp4a_cr_template.002.ent.FoundationContent.yaml
#     ibm_cp4a_cr_template.200.ent.ClientOnboardingDemoWithADP.yaml
cp4baTemplateToUse=ibm_cp4a_cr_template.002.ent.FoundationContent.yaml

# OCP Project Name for DB2, for example ibm-db2
db2OnOcpProjectName=REQUIRED

# Password for DB2 Admin User (Admin User name see below), for example passw0rd
db2AdminUserPassword=REQUIRED

# DB2 Standard license key base64 encoded
#   If this key is not available, leave empty (but remove the value 'REQUIRED') - then the Community edition is used that allows less CPU & RAM
#   In that case, also update parameters db2Cpu and db2Memory below (the defaults there assume you have a DB2 Standard license available)
db2StandardLicenseKey=REQUIRED

# CPUs to assign to DB2 pod (max with DB2 Standard license is 16, max with Community edition is 4)
#   If you selected CP4BA template     ibm_cp4a_cr_template.001.ent.Foundation.yaml                      set it to 4
#   If you selected CP4BA template     ibm_cp4a_cr_template.002.ent.FoundationContent.yaml               set it to 4
#   If you selected CP4BA template     ibm_cp4a_cr_template.200.ent.ClientOnboardingDemoWithADP.yaml     set it to 16
db2Cpu=4

# RAM to assign to DB2 pod (max with DB2 Standard license is 128Gi, max with Community edition is 16Gi)
#   If you selected CP4BA template     ibm_cp4a_cr_template.001.ent.Foundation.yaml                      set it to 16Gi
#   If you selected CP4BA template     ibm_cp4a_cr_template.002.ent.FoundationContent.yaml               set it to 16Gi
#   If you selected CP4BA template     ibm_cp4a_cr_template.200.ent.ClientOnboardingDemoWithADP.yaml     set it to 110Gi
db2Memory=16Gi



# -----------------------------------------------------
# --- Parameters that usually do NOT need an update ---
# -----------------------------------------------------

# --- If changes are needed here, provide those BEFORE running script 02-createDb2OnOCP.sh ---

# Version of DB2 operator to install. Change only when a new operator version should be used.
db2OperatorVersion=db2u-operator.v1.1.9

# Channel version for Operator updates. Change only if a new DB2 operator version requires a new channel version.
db2OperatorChannel=v1.1

# DB2 instance version to be created. Change only when a new version of DB2 should be used.  
# This version of DB2 must be supported by the Operator version installed as specified above.
db2InstanceVersion=11.5.6.0

# Indicate if to install DB2 containerized on the OpenShift cluster (true/false)
db2UseOnOcp=true

# DB2 instance access information.
# This uses the DB2 nodeport service name to access DB2
db2HostName=c-db2ucluster-db2u-engn-svc.${db2OnOcpProjectName}.svc

# If the service name is used, the port is 5000 and does not need to be changed
# If using IP address or a HAProxy to access the node port, the port number
# would need to change.
db2PortNumber=50000

# IP for DB2 instance access information.  If IP must be specified use otherwise leave as specified
db2HostIp=$db2HostName

# DB2 Admin User name - when using Db2 on OCP pls. do not change db2AdminUserName, it must be "db2inst1"
db2AdminUserName=db2inst1

# Deployment platform, either ROKS or OCP
cp4baDeploymentPlatform=ROKS

# Name of the storage class used for DB2's PVC
db2OnOcpStorageClassName=cp4a-file-delete-gold-gid

# Size of the PVC for DB2 (on ROKS: the larger the faster, good performance with 500Gi)
db2StorageSize=150Gi

# Database activation delay. Scripts will wait this time in seconds between activating databases.
# With problems on activation, or if on slow environments, try to increase this delay
db2ActivationDelay=15

# Number of DBs that should be supported by the DB instance
db2NumOfDBsSupported=30

# CP4BA Database Name information
db2IcndbName=ICNDB
db2ClosName=CLOS
db2Devos1Name=DEVOS1
db2AeosName=AEOS
db2BawDocsName=BAWDOCS
db2BawTosName=BAWTOS
db2BawDosName=BAWDOS
db2BawDbName=BAWDB
db2AppdbName=APPDB
db2AedbName=AEDB
db2BasdbName=BASDB
db2GcddbName=GCDDB

# Indicate if you want to deploy ADP, if so provide the ADP Database Name information

# ADP Configuration
# By default our configuration creates ADP databases on the same database instance as the rest of the cloudpak
# here we give you the opportunity to configure it differently so that you can create a separate database instance just for ADP
# and get our templates to use those values instead

# Flag indicating that ADP should be configured
db2CreateAdpDbs=false

# DB2 settings for ADP databases, by default same as the rest of the other components
# Only overwrite if ADP will use a separate DB2 instance
adpDb2OnOcpProjectName=$db2OnOcpProjectName
adpDb2AdminUserName=$db2AdminUserName
adpDb2AdminUserPassword=$db2AdminUserPassword
adpDb2Cpu=$db2Cpu
adpDb2Memory=$db2Memory
adpDb2NumOfDBsSupported=$db2NumOfDBsSupported
adpDb2StorageSize=$db2StorageSize
adpDb2OnOcpStorageClassName=$db2OnOcpStorageClassName
adpDb2PortNumber=$db2PortNumber
adpDb2HostName=$db2HostName


# Name of the base Content Analizer database for ADP
db2CaBasedbName=BASECA
# All tenant DBs will be created using this prexi
db2TenantDBPrefix=PDB
numberTenantDBs=6

# --- end of file ---



