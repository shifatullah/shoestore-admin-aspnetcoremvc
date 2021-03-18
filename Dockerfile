FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1-focal AS build
WORKDIR /src
COPY . .
WORKDIR "/src/ShoeStore.Admin.AspNetCoreMvc"
RUN dotnet restore "ShoeStore.Admin.AspNetCoreMvc.csproj"
RUN dotnet build "ShoeStore.Admin.AspNetCoreMvc.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ShoeStore.Admin.AspNetCoreMvc.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ShoeStore.Admin.AspNetCoreMvc.dll"]