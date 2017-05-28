-- Deletes dot files in the home directory


function deleteFiles()
  -- Be _really_ careful which files you put into this array.
  -- The code below calls `rm` on whatever's in here.
  -- This could be an excellent way to destroy your system.
  files = {"~/.bash_history", "~/.zsh_history"}

  for fileCount = 1, #files do
    file = files[fileCount]
    os.execute("rm " .. file)
  end
end

hs.hotkey.bind({"alt", "cmd", "ctrl"}, "d", function()
    deleteFiles()
    hs.alert.show("Files have been deleted")
end)
