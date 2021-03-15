FROM registry.fedoraproject.org/fedora:33

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
RUN npm i -g yarn @vue/cli typescript

# Setup rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN source $HOME/.cargo/env
