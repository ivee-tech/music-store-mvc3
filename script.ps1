$msbuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
$msbuildPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
Set-Alias -Name msbuild -Value $msbuildPath

# install appcat
dotnet tool install -g dotnet-appcat
# or, if you have additional sources configured, try the following:
dotnet tool install -g --ignore-failed-sources dotnet-appcat

# analyse
appcat analyze .

# Create a package using msbuild
$projectFile = "MvcMusicStore-Completed\MvcMusicStore.csproj"
$packageOutputFolder = "MvcMusicStore-Completed\publish"
msbuild $projectFile /t:Package /p:PackageLocation=$packageOutputFolder\MvcMusicStore.zip

# Deploy the package to a folder using msdeploy
$targetFolder = "path\to\target\folder"
& 'msdeploy.exe' -verb:sync -source:package="$packageOutputFolder\Project.zip" -dest:auto,dirPath=$targetFolder


# cd MvcMusicStore-Completed\MvcMusicStore
docker build -t music-store:latest .
docker run -d -p 8080:80 music-store:latest


$connectionString = 'Data Source=host.docker.internal,1433;Initial Catalog=C1;User ID=sa;Password=***;'
$connectionString = 'Data Source=sqlsvr,1433;Initial Catalog=C1;User ID=sa;Password=***;'
$s = "Server=tcp:zz-auea-dev-sql-zz002.database."
$s += "windows.net,1433;Initial Catalog=zz-auea-"
$s += "dev-db-zz002;Persist Security Info=False;"
$s += "User ID=sqlusr001;Password='***"
$s += "***';MultipleActiveResult"
$s += "Sets=False;Encrypt=True;TrustServerCertif"
$s += "icate=False;Connection Timeout=30;"
$connection = New-Object System.Data.SqlClient.SqlConnection($s)
$connection.Open()
$connection.Close()


# push to external registry
$tag='1.0.0-mvc3'
$image='music-store'
# docker hub
$registry='docker.io'
$rns='daradu' # namespace
# acr
$registry='ktbacr.azurecr.io'
$rns='cmf' # namespace

$img="${image}:${tag}"
docker tag "${image}:latest" ${img}
docker tag ${img} ${registry}/${rns}/${img}
# requires docker login
az acr login --name $registry
docker push ${registry}/${rns}/${img}
