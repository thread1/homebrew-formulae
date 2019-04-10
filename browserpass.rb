class Browserpass < Formula
  desc "This is a host application for browserpass browser extension providing it access to your password store."
  homepage "https://github.com/browserpass/browserpass-native"
  url "https://github.com/browserpass/browserpass-native/releases/download/3.0.4/browserpass-darwin64-3.0.4.tar.gz"
  sha256 "5cea2a332d3bd58f14bd6d597b0e96937806cd991ef9fd4c916e6b2559746ee7"

  patch do
	url "https://patch-diff.githubusercontent.com/raw/browserpass/browserpass-native/pull/44.patch"
    sha256 "bbefc9abec57130ce0d5bda9af923f54949b4729ac85ba1348d79ab50c355767"
  end

  depends_on "coreutils" => :build
  depends_on "gnu-sed" => :build
  depends_on "gpg"
  depends_on "pinentry"
  depends_on "pinentry-mac"

  def install

	ENV["DESTDIR"] = ""
	ENV["PREFIX"] = "#{prefix}"
	ENV["BIN"] = "browserpass-darwin64"

    system "make", "configure"
	system "make", "install"

	# NOT possible to symlink the hosts files from a homebrew formula, since they go under HOME
	# Unfortunately, need to have the user do them manually
	# (same with policies, if the user wants them)

  end

  def caveats
	<<~EOF
	Due to homebrew formula limitations, this tap only installs the native binary.

	To install nativemessaginghost bindings for your browser, run the following:
	$ cd /usr/local/opt/browserpass/lib
	$ DESTDIR='' PREFIX='/usr/local/opt/browserpass' make hosts-BROWSER-user

	Where BROWSER is one of the following:
	[chromium chrome vivaldi brave firefox]

	NOTE: This tap DOES NOT install the browser extension automatically.
	You should go to the browser and manually install the extension there.
	EOF
  end

  test do
	# how to get this to work?
#   	(testpath/"request.hex.txt").write << END_OF_TEST
#   .   {"action":"search","domain":"www.github.com"}
#   	END_OF_TEST
	# ./browserpass-darwinx64 <<< '.{"action":"search","domain":"www.github.com"} '
	system "true"
  end
end
