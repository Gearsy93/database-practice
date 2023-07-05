using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace ORM
{
    public partial class pastryContext : DbContext
    {
        public pastryContext()
        {
        }

        public pastryContext(DbContextOptions<pastryContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Cheque> Cheques { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<DeliveryAddress> DeliveryAddresses { get; set; }
        public virtual DbSet<Ingredient> Ingredients { get; set; }
        public virtual DbSet<IngredientMealCount> IngredientMealCounts { get; set; }
        public virtual DbSet<Manager> Managers { get; set; }
        public virtual DbSet<Meal> Meals { get; set; }
        public virtual DbSet<MealCount> MealCounts { get; set; }
        public virtual DbSet<MealPrice> MealPrices { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<Procurement> Procurements { get; set; }
        public virtual DbSet<Sex> Sexes { get; set; }
        public virtual DbSet<Supplier> Suppliers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseNpgsql("Host=localhost;Database=pastry;Username=postgres;Password=postgres");
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Russian_Russia.1251");

            modelBuilder.Entity<Cheque>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("cheque");

                entity.Property(e => e.CustomerId).HasColumnName("customer_id");

                entity.Property(e => e.DeliveryAddressId).HasColumnName("delivery_address_id");

                entity.Property(e => e.ManagerId).HasColumnName("manager_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.Property(e => e.OrderNumber).HasColumnName("order_number");

                entity.HasOne(d => d.Customer)
                    .WithMany()
                    .HasForeignKey(d => d.CustomerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("cheque_customer_customer_id_fk");

                entity.HasOne(d => d.DeliveryAddress)
                    .WithMany()
                    .HasForeignKey(d => d.DeliveryAddressId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("cheque_delivery_address_delivery_address_id_fk");

                entity.HasOne(d => d.Manager)
                    .WithMany()
                    .HasForeignKey(d => d.ManagerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("cheque_manager_manager_id_fk");

                entity.HasOne(d => d.Order)
                    .WithMany()
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("cheque_order_order_id_fk");
            });

            modelBuilder.Entity<Customer>(entity =>
            {
                entity.ToTable("customer");

                entity.HasIndex(e => e.CustomerId, "customer_customer_id_uindex")
                    .IsUnique();

                entity.Property(e => e.CustomerId).HasColumnName("customer_id");

                entity.Property(e => e.Customer1)
                    .HasMaxLength(50)
                    .HasColumnName("customer");

                entity.Property(e => e.Phone).HasColumnName("phone");

                entity.Property(e => e.SexId).HasColumnName("sex_id");

                entity.HasOne(d => d.Sex)
                    .WithMany(p => p.Customers)
                    .HasForeignKey(d => d.SexId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("customer_sex_sex_id_fk");
            });

            modelBuilder.Entity<DeliveryAddress>(entity =>
            {
                entity.ToTable("delivery_address");

                entity.HasIndex(e => e.DeliveryAddressId, "delivery_address_delivery_address_id_uindex")
                    .IsUnique();

                entity.Property(e => e.DeliveryAddressId).HasColumnName("delivery_address_id");

                entity.Property(e => e.Address)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("address");

                entity.Property(e => e.City)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("city");

                entity.Property(e => e.Index).HasColumnName("index");
            });

            modelBuilder.Entity<Ingredient>(entity =>
            {
                entity.ToTable("ingredient");

                entity.HasIndex(e => e.IngredientId, "ingredient_ingredient_id_uindex")
                    .IsUnique();

                entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");

                entity.Property(e => e.CountryOrigin)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("country_origin");

                entity.Property(e => e.Ingredient1)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("ingredient");

                entity.Property(e => e.Measurement)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("measurement");

                entity.Property(e => e.Weight).HasColumnName("weight");
            });

            modelBuilder.Entity<IngredientMealCount>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("ingredient_meal_count");

                entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");

                entity.Property(e => e.IngredientMealCount1).HasColumnName("ingredient_meal_count");

                entity.Property(e => e.MealId).HasColumnName("meal_id");

                entity.HasOne(d => d.Ingredient)
                    .WithMany()
                    .HasForeignKey(d => d.IngredientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("ingredient_meal_count_ingredient_ingredient_id_fk");

                entity.HasOne(d => d.Meal)
                    .WithMany()
                    .HasForeignKey(d => d.MealId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("ingredient_meal_count_meal_meal_id_fk");
            });

            modelBuilder.Entity<Manager>(entity =>
            {
                entity.ToTable("manager");

                entity.HasIndex(e => e.ManagerId, "manager_manager_id_uindex")
                    .IsUnique();

                entity.Property(e => e.ManagerId).HasColumnName("manager_id");

                entity.Property(e => e.Manager1)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("manager");

                entity.Property(e => e.Phone).HasColumnName("phone");

                entity.Property(e => e.SexId).HasColumnName("sex_id");

                entity.HasOne(d => d.Sex)
                    .WithMany(p => p.Managers)
                    .HasForeignKey(d => d.SexId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("manager_sex_sex_id_fk");
            });

            modelBuilder.Entity<Meal>(entity =>
            {
                entity.ToTable("meal");

                entity.HasIndex(e => e.MealId, "meal_meal_id_uindex")
                    .IsUnique();

                entity.Property(e => e.MealId).HasColumnName("meal_id");

                entity.Property(e => e.Calories).HasColumnName("calories");

                entity.Property(e => e.Meal1)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasColumnName("meal");

                entity.Property(e => e.Weight).HasColumnName("weight");
            });

            modelBuilder.Entity<MealCount>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("meal_count");

                entity.Property(e => e.MealCount1).HasColumnName("meal_count");

                entity.Property(e => e.MealId).HasColumnName("meal_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.HasOne(d => d.Meal)
                    .WithMany()
                    .HasForeignKey(d => d.MealId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("meal_count_meal_meal_id_fk");

                entity.HasOne(d => d.Order)
                    .WithMany()
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("meal_count_order_order_id_fk");
            });

            modelBuilder.Entity<MealPrice>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("meal_price");

                entity.Property(e => e.MealId).HasColumnName("meal_id");

                entity.Property(e => e.MealPrice1).HasColumnName("meal_price");

                entity.Property(e => e.OrderDate)
                    .HasColumnType("date")
                    .HasColumnName("order_date");

                entity.HasOne(d => d.Meal)
                    .WithMany(p => p.MealPrices)
                    .HasForeignKey(d => d.MealId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("meal_price_meal_meal_id_fk");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("order");

                entity.HasIndex(e => e.OrderId, "order_order_id_uindex")
                    .IsUnique();

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.Property(e => e.IngredientId).HasColumnName("ingredient_id");

                entity.Property(e => e.MealId).HasColumnName("meal_id");

                entity.Property(e => e.OrderDate)
                    .HasColumnType("date")
                    .HasColumnName("order_date")
                    .HasDefaultValueSql("now()");

                entity.Property(e => e.ProcurementId).HasColumnName("procurement_id");

                entity.HasOne(d => d.Ingredient)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.IngredientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("order_ingredient_ingredient_id_fk");

                entity.HasOne(d => d.Meal)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.MealId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("order_meal_meal_id_fk");

                entity.HasOne(d => d.Procurement)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.ProcurementId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("order_procurement_procurement_id_fk");
            });

            modelBuilder.Entity<Procurement>(entity =>
            {
                entity.ToTable("procurement");

                entity.HasIndex(e => e.ProcurementId, "procurement_procurement_id_uindex")
                    .IsUnique();

                entity.Property(e => e.ProcurementId).HasColumnName("procurement_id");

                entity.Property(e => e.Date)
                    .HasColumnType("date")
                    .HasColumnName("date")
                    .HasDefaultValueSql("now()");

                entity.Property(e => e.SupplierId).HasColumnName("supplier_id");

                entity.HasOne(d => d.Supplier)
                    .WithMany(p => p.Procurements)
                    .HasForeignKey(d => d.SupplierId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("procurement_supplier_supplier_id_fk");
            });

            modelBuilder.Entity<Sex>(entity =>
            {
                entity.ToTable("sex");

                entity.HasIndex(e => e.SexId, "sex_sex id_uindex")
                    .IsUnique();

                entity.Property(e => e.SexId).HasColumnName("sex_id");

                entity.Property(e => e.Sex1)
                    .IsRequired()
                    .HasMaxLength(1)
                    .HasColumnName("sex");
            });

            modelBuilder.Entity<Supplier>(entity =>
            {
                entity.ToTable("supplier");

                entity.HasIndex(e => e.SupplierId, "supplier_supplier_id_uindex")
                    .IsUnique();

                entity.Property(e => e.SupplierId).HasColumnName("supplier_id");

                entity.Property(e => e.Phone).HasColumnName("phone");

                entity.Property(e => e.SexId).HasColumnName("sex_id");

                entity.Property(e => e.Supplier1)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("supplier");

                entity.HasOne(d => d.Sex)
                    .WithMany(p => p.Suppliers)
                    .HasForeignKey(d => d.SexId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("supplier_sex_sex_id_fk");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
