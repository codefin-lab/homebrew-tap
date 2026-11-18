cask "bifrost" do
  version "0.2.0+89"
  sha256 "368fde496d1854b658394b35fcf6e056fee4662b0cc97a1f878f041854964ccc"

  url "https://pkg.bifrostvpn.co/mac/Bifrost-#{version.tr("+", ".")}.pkg"
  name "Bifrost"
  desc "Mesh VPN for organisations"
  homepage "https://bifrostvpn.co/"

  livecheck do
    url "https://pkg.bifrostvpn.co/dev.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :sonoma

  pkg "Bifrost-#{version.tr("+", ".")}.pkg"

  uninstall early_script: {
              executable:   "/Applications/Bifrost.app/Contents/Resources/uninstall-service.sh",
              sudo:         true,
              must_succeed: false,
            },
            launchctl:    [
              "io.codefin.bifrost.check",
              "io.codefin.bifrostd",
            ],
            quit:         "io.codefin.bifrost",
            pkgutil:      "io.codefin.bifrost.pkg",
            delete:       [
              "/Applications/Bifrost.app",
              "/Library/LaunchDaemons/io.codefin.bifrost.check.plist",
              "/Library/LaunchDaemons/io.codefin.bifrostd.plist",
              "/Library/PrivilegedHelperTools/io.codefin.bifrost",
              "/Library/PrivilegedHelperTools/io.codefin.bifrostd",
            ]

  zap trash: [
    "/var/lib/bifrost",
    "~/Library/Application Support/Bifrost",
    "~/Library/Caches/Bifrost",
    "~/Library/Caches/io.codefin.bifrost",
    "~/Library/HTTPStorages/io.codefin.bifrost",
    "~/Library/HTTPStorages/io.codefin.bifrost.binarycookies",
    "~/Library/Preferences/io.codefin.bifrost.plist",
  ]
end
