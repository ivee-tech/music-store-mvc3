using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace MvcMusicStore.Models
{
    public class MusicStoreEntities : DbContext
    {

        public MusicStoreEntities()
            : base("name=MusicStoreEntities")
        {
            var objectContext = ((IObjectContextAdapter)this).ObjectContext;
            objectContext.CommandTimeout = 180;
        }

        public DbSet<Album> Albums { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Artist> Artists { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
    }
}