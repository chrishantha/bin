git clone --bare https://github.com/chrishantha/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
BACKUP_DIR=".config-backup"
mkdir -p "${BACKUP_DIR}"
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mapfile -t dotfiles < <(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
    for dotfile in "${dotfiles[@]}"; do
      dir="$(dirname "${dotfile}")"
      target_dir=""${BACKUP_DIR}"/${dir}"
      if [[ ! -d "${target_dir}" ]]; then
          mkdir -p "${target_dir}"
      fi
	    mv -v ${dotfile} "${BACKUP_DIR}"/${dotfile}
    done
fi;
config checkout
config config status.showUntrackedFiles no
