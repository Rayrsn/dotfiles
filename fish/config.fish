if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_greeting
    #flashfetch | lolcat
    #figlet RayrOS -f slant| lolcat
    set powered_msgs \
	"figlet JoeOS -f slant| lolcat" \
	"figlet JoeOS | lolcat"\
	"figlet RayrOS -f slant| lolcat" \
	"figlet RayrOS | lolcat"

	# Randomly pick a message
     set chosen_msg (random)"%"(count $powered_msgs)
     set chosen_msg $powered_msgs[(math $chosen_msg"+1")]
     bash -c $chosen_msg
     echo ""
end
