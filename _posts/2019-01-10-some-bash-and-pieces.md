---
layout: post
locale: en
title:  "Bash and Pieces"
date:   2018-01-10 13:30:00
categories: bash linux
excerpt: "Here is a list of &quote;useful&quote; bash commands that I always seem to forget ..."
---

### Get CPU percentage

```
top -bn 2 -d 0.1 | grep -E '^(%)?Cpu' | tail -n 1 | awk '{print $2+$4+$6}'

# top -b        for batch
# top -n 2      for 2 sequences
# top -d 0.1    difference of 0.1 second
# grep -E       for regex pattern - some OS will start the line with %Cpu and some other won't
# tail -n 1     to get the last line
# awk           to add numbers up
```

### Get Memory percentage

```
free -t | grep 'Total' | awk '{print ($3 * 100) / $2 }'

# free -t       to display the total
# grep          the last line
# awk           to make a percentage
```

### Count the total number of docker containers

```
docker ps -aq | wc -l

# docker ps     will list the docker containers - you can filter stuff here with the --filter parameter
# wc -l         counts the total of line
```

### Get a timestamp in seconds

```
date +%s%N | cut -b1-13

# cut -b1-13    will keep the 13 first digits which is what we want because the date will return the nano seconds
```

### Prompt for user input with a timeout

Sometimes people fall asleep in front of their screen so a simple `read -p "your question:" $value;` will be prompted for ever... Add a timeout!

```
printf "What is your favourite colour?\n"
read -t 10 $colour;

if [[ $? = "1" ]]; then
    printf "Are you asleep?"
    read -t 10 $colour;
fi
```

Note that once the timeout of 10 seconds is reached, the command will fail with the error code "1".