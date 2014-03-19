#!/bin/zsh

function git-purge-branches {
  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

  if ! [ "$CURRENT_BRANCH" = 'master' ]; then
    echo 'Please stash your work and checkout master'
    return
  fi

  git fetch -p
  ggpull

  BRANCHES=`git branch --merged master | grep --invert-match -E "master"`

  if [ $BRANCHES ]; then
    echo 'The following local branches will be removed: '
    echo $BRANCHES
    read "REPLY?Continue (y/n)? "
    if [ "$REPLY" = "y" ]; then
      echo $BRANCHES | xargs git branch -d
    fi
  fi

  BRANCHES=`git branch -r --merged master | grep --invert-match -E "master" | grep "origin" | sed -e "s#origin/##"`

  if [ $BRANCHES ]; then
    echo 'The following remote branches will be removed: '
    echo $BRANCHES
    read "REPLY?Continue (y/n)? "
    if [ "$REPLY" = "y" ]; then
      echo $BRANCHES | sed -e 's/^ */ :/' | tr -d '\n' | xargs git push origin
    fi
  fi
}

reset-dbs () {
  reset_db() {
    sudo mysqladmin -f drop $db_name; sudo mysqladmin -f create $db_name
  }
  for project in api_ wrapport_ merchant_reports_ reporting_ giftcards_ useradmin_ events_ ''
  do
    for db in events model social codes news id_service stats person_shard_0 person_shard_1 events cardlinks merchants orders rewards wrapport notifications friendships;
    do
      db_name='wrapptest_'$project''$db;
      echo $db_name | reset_db
    done;
  done;
  for db in wrapptest_giftcards wrapptest_cardlinks localhost/wrapptest_social_person_shard_0 localhost/wrapptest_social_person_shard_1 localhost/wrapptest_id_service wrapptest_social_friendships
    do
      db_name=$db;
      echo $db_name | reset_db
  done;
}

function gdel() {
  branch="$*";
  git branch -D $branch && git push origin :$branch
}

function gcb() {
  current_branch=`git rev-parse --abbrev-ref HEAD` | tr -d "\n";
  branch="origin/"$current_branch
  echo $branch | tr -d "\n" | pbcopy;
  echo "Copied "$branch
}

function jenkins() {
  JENKINS_URL=http://wrapp:ty3798y2f3@jenkins.wrapp.com/ nestor $* `basename $PWD`-`git rev-parse --abbrev-ref HEAD`
}

function gfs() {
  branch="$*";
  git fetch && git branch $branch && git checkout $branch
}

function gff() {
  branch=`git rev-parse --abbrev-ref HEAD`
  git checkout master && git pull origin master && git merge $branch && git push origin master && gdel $branch
}

function volatile-checkout() {
  while read line
  do
    parts=(${(ps: :)${line}})
    repo=$parts[1]
    tag=$parts[2]
    if [ -d "$repo/.git" ]; then
      (
      cd "$repo"
      git checkout -q "$tag"
      )
      echo $repo is now at $tag
    fi
  done
  unset line
}
