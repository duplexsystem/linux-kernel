# remove any existing linux repo
rm -rf  ./linux
#clone repo from github. was using torvalds offical but it was too slow & this is already hosted on github anyways (if that changes I'm switching back to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git) uses set version and patchlevel for script code and less bugs from patches failing to apply and or not working correctly with new versions
git clone --branch v5.13 --single-branch https://github.com/torvalds/linux.git
#enter newly cloned linux repo
cd linux
# apply patches from main git repo in numerical order
for D in ../patches/*/; do  git am  --ignore-whitespace ${D}*.patch; done



