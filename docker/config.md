## Problem: you log into container, press Ctrl-P and find out you need to press it twice every god damn time

Solution:
Add it to  ~/.docker/config.json
```
{
    "detachKeys": "ctrl-]"
}
```
