using EmployeeManagementSystemTaskDec24.Repository.Interfaces;
using EmployeeManagementSystemTaskDec24.Repository.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
// Add the database connection string for repositories
builder.Services.AddSingleton(provider =>
    builder.Configuration.GetConnectionString("ConnectionString"));

builder.Services.AddScoped<IEmployeeRepository>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("ConnectionString");
    return new EmployeeRepository(connectionString);
});
builder.Services.AddScoped<IPerformanceReviewRepository>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("ConnectionString");
    return new PerformanceReviewRepository(connectionString);
});
builder.Services.AddScoped<IDepartmentRepository>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("ConnectionString");
    return new DepartmentRepository(connectionString);
});




var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
