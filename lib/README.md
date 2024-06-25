This directory may not stay.
It does not have a bearing on the functionality of the track.

For now, it's a place to store code the practice exercises may reuse.

## bats files

Also in here, bats files common to all exercises.

* to deploy bats files to all exercises:

    ```bash
    for e in ./exercises/{concept,practice}/*/; do
        for f in ./lib/bats-*.bash; do
            g=$(basename "$f")
            if [[ ! -f "$e/$g" ]] || ! cmp "$e/$g" "./lib/$g"; then
                cp -vp "./lib/$g" "$e/$g"
            fi
        done
    done
    ```
