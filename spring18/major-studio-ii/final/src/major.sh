while true
do
  say "Hi"
  say "This is my project"
  say "A study of machine learning in UX"
  say "Please see the presentation, lol, meaning laugh out loud"

  sleep 2
  while true; do
    say "OK, how can I help you"
    echo "Can I help you?"
    read -p "Press y/n + Enter" yn
    case $yn in
        [Yy]* ) say "Ok, Kevin can help you"; open "tel://3239073871";;
        [Nn]* ) say "Bye, bye, lmpo, meaning laugh, my, processor, out"; break;;
        * ) say "Hey,  Are you still there. Press something please!"; sleep 2;;
    esac
  done

  sleep 3
done
