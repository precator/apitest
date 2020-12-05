FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 2000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["apitest.csproj", "./"]
RUN dotnet restore "apitest.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "apitest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "apitest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "apitest.dll"]





