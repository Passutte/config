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

### Docker utilities
ada(){
    running_containers=$(docker container ls -af status=running --format '{{.Names}}')
    stopped_containers=$(docker container ls -af status=exited --format '{{.Names}}')
    container=$(printf '%s\n%s' "$running_containers" "$stopped_containers" | fzf)
    if [ $? = 0 ] && [[ "$container" != "" ]]; then
        if grep "$container"<<<"$running_containers" > /dev/null; then
            docker container exec -it "$container" bash -c "su $USER"
        elif grep "$container"<<<"$stopped_containers" > /dev/null; then
            docker start -ai "$container"
        fi
    fi
}

