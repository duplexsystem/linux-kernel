BRANCH=v5.13

FILE=./linux
if [ -d "$FILE" ]; then
    #enter existing dir
    cd linux
    #remove old rebases
    rm -rf ./.git/rebase-apply
    #update repo
    git fetch origin $BRANCH
    git reset --hard $BRANCH
else
    #clone repo from github. was using torvalds offical but it was too slow & this is already hosted on github anyways (if that changes I'm switching back to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) uses set version and patchlevel for script code and less bugs from patches failing to apply and or not working correctly with new versions
    git clone --branch $BRANCH --single-branch https://github.com/torvalds/linux.git
    #enter newly cloned linux repo
    cd linux
fi

# apply patches from main git repo in numerical order
for D in ../patches/*/; do  git am --whitespace=fix  ${D}*.patch; done


#kiss fix
sed '/<stdlib.h>/a #include <linux/stddef.h>' \
    tools/objtool/arch/x86/decode.c > _
mv -f _ tools/objtool/arch/x86/decode.c

