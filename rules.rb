# Sample Maid rules file -- some ideas to get you started.
#
# To use, remove ".sample" from the filename, and modify as desired.  Test using:
#
#     maid clean -n
#
# **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
# what they do, you might run into unwanted results!
#
# Don't forget, it's just Ruby!  You can define custom methods and use them below:
# 
#     def magic(*)
#       # ...
#     end
# 
# If you come up with some cool tools of your own, please send me a pull request on GitHub!  Also, please consider sharing your rules with others via [the wiki](https://github.com/benjaminoakes/maid/wiki).
#
# For more help on Maid:
#
# * Run `maid help`
# * Read the README, tutorial, and documentation at https://github.com/benjaminoakes/maid#maid
# * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)
# * Check out how others are using Maid in [the Maid wiki](https://github.com/benjaminoakes/maid/wiki)

Maid.rules do
  # **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
  # what they do, you might run into unwanted results!

  rule 'Update yourself' do
    `cd ~/.maid && git pull`
  end

  rule 'Push pass changes up' do
    `cd ~/.password-store && git push origin --all && git push github --all`
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
