FROM registry.fedoraproject.org/fedora-toolbox:34

# Install extra packages
COPY packages /
RUN dnf -y install $(<packages)
RUN rm /packages

# Configure OpenSSH server
RUN printf "Port 2222\nListenAddress localhost\nPermitEmptyPasswords yes\n" >> /etc/ssh/sshd_config \
	&& /usr/libexec/openssh/sshd-keygen rsa \
	&& /usr/libexec/openssh/sshd-keygen ecdsa \
	&& /usr/libexec/openssh/sshd-keygen ed25519

# Add global node packages
RUN npm i -g yarn 
RUN yarn global add @vue/cli typescript

# Run CMD because otherwise everything bricks 
CMD /bin/zsh
