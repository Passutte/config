##############################################################
###### MY CUSTOMIZATION ######################################
##############################################################

### ROS Nodes not shutting down properly
kill_ps() {
       	sudo ps -ef | grep $1 | grep -v grep| awk '{print $2}'  | xargs -r sudo kill -9
 }

clean_sim() {
       	kill_ps catkin
   	kill_ps noetic
	rm /dev/shm/COSMO_SHM
}

