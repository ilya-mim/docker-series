FROM mcr.microsoft.com/dotnet/core/sdk:2.2 as build-image

WORKDIR /home/app

COPY ./*.sln ./
COPY ./*/*.csproj ./
RUN for file in $(ls *.csproj); do mkdir -p ./${file%.*}/ && mv $file ./${file%.*}/; done

RUN dotnet restore

COPY . .

RUN dotnet test --verbosity=normal ./Tests/Tests.csproj

RUN dotnet publish ./AccountOwnerServer/AccountOwnerServer.csproj -o /publish/

FROM microsoft/aspnetcore

WORKDIR /publish

COPY --from=build-image /publish .

ENV TEAMCITY_PROJECT_NAME = ${TEAMCITY_PROJECT_NAME}

ENTRYPOINT ["dotnet", "AccountOwnerServer.dll"]