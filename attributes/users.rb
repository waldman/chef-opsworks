#
# Users Attributes
#

# Sudo Cookbook
node.default['authorization']['sudo']['include_sudoers_d'] = true

# Groups
node.default['defaults']['user_groups']['sysadmin'] = 2000

# Users
node.default['defaults']['users']['leon.waldman']['uid'] = '1500'
node.default['defaults']['users']['leon.waldman']['groups'] = ['sysadmin', 'sudo']
node.default['defaults']['users']['leon.waldman']['comment'] = 'Leon Waldman'
node.default['defaults']['users']['leon.waldman']['shell'] = '/bin/bash'
node.default['defaults']['users']['leon.waldman']['sshkeys'] = ['ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA0R9VMRVpdDtklFnXIGjBGlcnd66mSZ4+67WLD70QccIzClTRPuqFa4ys5Pb5GOibrkjReuqEFfDCYmQF+UTtS1LtKhBRXpTunyDHpSUSqFK+Omt+fRdWKDWDb9TSlUiC/Pk3AeFPIx6Nnk4BPHOEW0rlaPzd9O/aZys+xjPrFw/KXqBnu8PNa3OCnkiu5VsfNRO4LwHVxKz3IO9XcUskqQ3eaxH7Hrz1j1dvhJO83vBoh/reOZavO/RxY+8hHvaWwRlZXSJXhFFLlQZV08E1gI/eZLaIasYSL72SxsoaiNYrz6VWMeYn+LEySKN3V0t9TSVZUmVZUCyq1CiZTwMswkGBApz/Ys4S3a5p1CrYdkGu5Yk5zhbA4R0C+JiE8D46P430ZDza8q/j1xBUCWWxVCV1H/MAIdfB3tFX0fKSBubW/sTLbpGHiM11QWHjejGSZPFnDTAPcmTXwKUWW+KY/QbQ+bsRgWkfR857uRsBhbg4wnj/nl1yhZdFNtZN5U4/FeFAYOR1C92DjcVT1hUvZosD+9Mt378x1aF9MlRp4H70LNI5+dNWhnWxM/3pMXYU/u2viwVUotfsHIbbqtW720Kj8ugXYoZPDxY2pMMB9F59w+VkRE1GMbpyobY9vNWPyLw40NRrkiU+MpvVzljWTGOqPavyaXskXzV1Hv41oTU= le.waldman@gmail.com']

