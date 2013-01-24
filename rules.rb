
Maid.rules do

  rule 'Update yourself' do
    `cd ~/.maid && git pull`
  end

  rule 'Push pass changes up' do
    `cd ~/.password-store && git push origin --all && git push depot --all`
  end

  rule 'Push todo changes up' do
    `cd ~/Documents/todo && git push depot --all`
  end

  rule 'Dump my temporary folder' do
    mkdir('~/tmp')
    trash('~/tmp')
    mkdir('~/tmp')
  end

  rule "Trash files that shouldn't have been downloaded" do
    # It's rare that I download these file types and don't put them somewhere else quickly.  More often, these are still in Downloads because it was an accident.
    dir('~/Downloads/*.{csv,doc,docx,ics,ppt,js,rb,xml,xlsx}').each do |p|
      trash(p) if 3.days.since?(accessed_at(p))
    end
  end

  rule 'Downloaded archives' do
    dir('~/Downloads/*.{iso,rpm,deb,dmg,exe,pkg,tgz,tar.gz,zip,gzip}').each do |p|
      trash(p) if 3.days.since?(accessed_at(p))
    end
  end

  rule 'Remove empty directories' do
    dir(['~/Downloads/*']).each do |path|
      if File.directory?(path) && dir("#{ path }/*").empty?
        trash(path)
      end
    end
  end
end

