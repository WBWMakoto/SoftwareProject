using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace DeAnNhom.Models
{
    public class ApplicationUser : IdentityUser
    {
        [NotMapped]
        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        public void SaveChange() => db.SaveChanges();

        public async Task<int> SaveChangesAsync() => await db.SaveChangesAsync();

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }

        public virtual string ProfileImg { get; set; } = "https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg";
        public virtual Nullable<bool> Genders { get; set; }
        public virtual DateTime JoinedDate { get; set; } = DateTime.Now;

        public virtual Customer Customer => db.Customers.SingleOrDefault(c => c.CustomerID == Id);

        public virtual Seller Seller => db.Sellers.SingleOrDefault(c => c.SellerID == Id);
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DeAnNhomEntitiesapplication", throwIfV1Schema: false)
        {
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder); // This needs to go before the other rules!

            modelBuilder.Entity<IdentityUser>().ToTable("User").Property(p => p.Id).HasColumnName("UserID");
            modelBuilder.Entity<ApplicationUser>().ToTable("User").Property(p => p.Id).HasColumnName("UserID");
            modelBuilder.Entity<IdentityRole>().ToTable("Roles");
            modelBuilder.Entity<IdentityUserRole>().ToTable("UserRoles");
            modelBuilder.Entity<IdentityUserLogin>().ToTable("UserLogins");
            modelBuilder.Entity<IdentityUserClaim>().ToTable("UserClaims");
        }
    }
}