
PROJ = "TB Care Plan"


task :build =>  [] do
  p "Building #{PROJ}"
  %x[rm -rf dist]
  %x[mkdir dist]
  %x[perl bin/inliner.pl base_document/TB_plan_full.html > dist/TB_plan.html]
  p "Your single file distribution is in dist/ !"
end
