
using Login_signup.Class;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Npgsql;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors(options =>
{

    options.AddPolicy("AllowAngularApp",
        builder =>
        {
            builder.AllowAnyOrigin()// Update this with the actual URL of your Angular app
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});
builder.Services.AddHttpContextAccessor();
builder.Services.AddLogging();

// Get configuration for database connection
var configuration = builder.Configuration;
var dbConfiguration = configuration.GetSection("DBConfiguration").Get<DBConfiguration>();
var connectionString = $"Host={dbConfiguration!.Host};Port={dbConfiguration.Port};Username={dbConfiguration.Username};Password={dbConfiguration.Password};Database={dbConfiguration.Database}";

// Configure NpgsqlConnection service
builder.Services.AddScoped<NpgsqlConnection>(_ => new NpgsqlConnection(connectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "APIDatabaseDemo v1"));
}

app.UseHttpsRedirection();
app.UseAuthorization();

app.MapControllers();
app.UseCors("AllowAngularApp");
app.Run();

