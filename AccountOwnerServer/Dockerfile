FROM microsoft/aspnetcore

WORKDIR /home/app
COPY bin/Debug/netcoreapp2.0/publish .
ENTRYPOINT ["dotnet", "AccountOwnerServer.dll"]
