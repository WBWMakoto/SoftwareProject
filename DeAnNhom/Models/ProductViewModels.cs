using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web;

namespace DeAnNhom.Models
{
    public class ProductCreateViewModel
    {
        public string SellerID { get; set; }

        [Required(ErrorMessage = "Thiếu tên sản phẩm")]
        [Display(Name = "Tên sản phẩm")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Thiếu giá sản phẩm")]
        [Display(Name = "Giá")]
        [DataType(DataType.Currency)]
        public int ProductPrice { get; set; }

        [Required(ErrorMessage = "Thiếu mô tả sản phẩm")]
        [Display(Name = "Mô tả sản phẩm")]
        [DataType(DataType.MultilineText)]
        public string ProductDescription { get; set; }

        [Required]
        [Display(Name = "Danh mục")]
        public string CategoryID { get; set; }

        [Required(ErrorMessage = "Thiếu số lượng sản phẩm")]
        [Display(Name = "Số lượng")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Thiếu size sản phẩm")]
        [Display(Name = "Size")]
        public string ProductSizes { get; set; }

        [Required(ErrorMessage = "Thiếu ảnh sản phẩm")]
        public HttpPostedFileBase UploadImg { get; set; }
    }

    public class ProductAddToCartViewModel
    {
        public Product product { get; set; }

        public int ProductID { get; set; }

        [DefaultValue(1)]
        [Display(Name = "Số lượng")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Thiếu size sản phẩm")]
        [Display(Name = "Size")]
        public string Size { get; set; }
    }

    public class ProductPage
    {
        public PagedList.IPagedList<Product> PageProduct { get; set; }
        public List<Product> ListProduct { get; set; }
        public DeAnNhomDatabaseEntities Db { get; set; }
    }

    public class CreateCategoryViewModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Thiếu tên danh mục")]
        [Display(Name = "Tên danh mục")]
        public string CategoryName { get; set; }

        [Required(ErrorMessage = "Thiếu ảnh danh mục")]
        public HttpPostedFileBase CategoryImage { get; set; }
    }

}