# What is this doing here?
- Technically, this is not needed to achieve goals if you use the Ubuntu OVA + TF scripts. But, I don't like relying on Ubuntu.

# What is it?
- A working example of starting with a OpenSUSE ISO and inject Cloud-init + vmware guestinfo tools.

# Why?
- No one seemed to have a working Packer example for OpenSUSE 15.2 with vcenter that injects Cloud-init. So here it is.

# How?
$PWD assumes you are in the same folder as NOTES.md  
Currently this splits things into 3 vars files to enable required flexability down the road.
- secrets.pkrvars.hcl
- vcenter.pkrvars.hcl
- suse-template.pkrvars.hcl

Assuming you use valid data in the variable templates, the following command from a machine on the same network as vcenter, the vmware network assigned is as well, and that you are in this folder when launching it.
```
sudo podman run --rm \
    --network host -p 8080:80 \
    -v $PWD:/workspace -w /workspace \
    docker.io/hashicorp/packer:latest \
    build -var-file=./secrets.pkrvars.hcl \
    -var-file=./suse-template.pkrvars.hcl \
    -var-file=./vcenter.pkrvars.hcl .
```

# You might want to
- Update the hostname and domain if you copy paste my autoyast.xml 

# Your script is gross
- Submit a PR with a better one.

# Did you know you committed a password?
- Yes its password

# Things to fix.
- ~~Should probably drop json for packer's preferred style so we can better leverage certain behaviors at scale.~~ that was surprisingly easy, only ran into issues with lists of strings not converting properly.
- Cleanup the build block to consume scripts, so its also image agnostic. - This is next and shouldn't be too hard.
- Add CentOS8 and .. something else. I guess Debian.
- Swap from ISO's on disk to specific build URLs?

# Things todo
- Once a need arises for more than one packer image line, consider having a repo that deploys a Packer VM + Code and chrons to rebuild images frequently.