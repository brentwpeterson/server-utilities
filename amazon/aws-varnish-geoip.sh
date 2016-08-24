sudo rpm --nosignature -i https://repo.varnish-cache.org/redhat/varnish-4.0.el6.rpm
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

###########################################################
# Make sure you remove the packages in the Amazon main repo
###########################################################

sudo yum install varnish varnish-libs-devel
sudo yum install GeoIP-devel GeoIP-GeoLite-data automake autoconf libtool ncurses-devel libxslt groff pcre-devel pkgconfig jemalloc-devel python-docutils

mdir $HOME/src
cd ~/src
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
tar xvf autoconf-2.69.tar.gz
cd autoconf-2.69/
./configure
make
make install

cd ~/src
git clone https://github.com/varnish/libvmod-geoip
cd ~/src/libvmod-geoip

##################################
# Swtich to the Varnish 4.0 branch
##################################
./autogen.sh
./configure
make
make install

