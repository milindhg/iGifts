using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Microsoft.Samples.ServiceHosting.StorageClient;
using Microsoft.WindowsAzure.ServiceRuntime;
using System.Configuration;
using System.Collections.Specialized;


using System.Globalization;
using prototype3.Models;
using System.IO;
using System.Drawing;



namespace MvcApplication1
{
    public partial class upload : System.Web.UI.Page
    {
        string imageid;
        private BlobContainer container;
        private string uid;
        private BlobContainer GetContainer()
        {
            BlobStorage blobStorage = BlobStorage.Create(StorageAccountInfo.GetDefaultBlobStorageAccountFromConfiguration());
            BlobContainer newContainer = blobStorage.GetBlobContainer(RoleEnvironment.GetConfigurationSettingValue("ContainerName"));

            newContainer.CreateContainer(null, ContainerAccessControl.Public);
            return newContainer;
        }


        public void Page_Load(object sender, EventArgs e)
        {
            this.uid = Request.QueryString["id"];
            try
            {
                this.container = this.GetContainer();
                if (!IsPostBack)
                {
                    this.RefreshGallery();
                }
            }
            catch (System.Net.WebException we)
            {
                status.Text = "Network error: " + we.Message;
                if (we.Status == System.Net.WebExceptionStatus.ConnectFailure)
                {
                    status.Text += "<br />Please check if the blob storage service is running at " + ConfigurationManager.AppSettings["storageEndpoint"];
                }
            }
            catch (StorageException se)
            {
                Console.WriteLine("Storage service error: " + se.Message);
            }
        }

        private void RefreshGallery()
        {
            string imageprefix = "image_" + ((User)Session["Current"]).UserID.ToString();
            this.images.DataSource = this.container.ListBlobs(imageprefix, false);
            this.images.DataBind();
        }
        public void SaveImage(string uid, string name, string description, string tags, string fileName, string contentType, byte[] data)
        {
            BlobProperties properties = new BlobProperties(string.Format(CultureInfo.InvariantCulture, "image_{0}", uid));
            NameValueCollection metadata = new NameValueCollection();
            metadata["Id"] = uid;
            metadata["Filename"] = fileName;
            metadata["ImageName"] = String.IsNullOrEmpty(name) ? "unknown" : name;
            metadata["Description"] = String.IsNullOrEmpty(description) ? "unknown" : description;
            metadata["Tags"] = String.IsNullOrEmpty(tags) ? "unknown" : tags;
            properties.Metadata = metadata;
            properties.ContentType = contentType;
            BlobContents imageBlob = new BlobContents(data);
            this.container.CreateBlob(properties, imageBlob, true);
        }

        public void upload1_Click(object sender, EventArgs e)
        {
            if (imageFile.HasFile)
            {
                status.Text = "Inserted [" + imageFile.FileName + "] - Content Type [" + imageFile.PostedFile.ContentType + "] - Length [" + imageFile.PostedFile.ContentLength + "]";
                SaveImage(uid, imageName.Value, imageDescription.Value, imageTags.Value, imageFile.FileName, imageFile.PostedFile.ContentType, imageFile.FileBytes);
                RefreshGallery();
            }
            else
                status.Text = "No image file";

        }

        protected void OnBlobDataBound(object sender, ListViewItemEventArgs e)
        {

            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Repeater metadataRepeater = e.Item.FindControl("blobMetadata") as Repeater;
                BlobProperties blob = ((ListViewDataItem)(e.Item)).DataItem as BlobProperties;
                
                NameValueCollection metadata = container.GetBlobProperties(blob.Name).Metadata;

                int curid = int.Parse(metadata[metadata.AllKeys[0]]);

                if (curid == (int)((User)Session["Current"]).UserID)
                {

                    metadataRepeater.DataSource = from key in metadata.AllKeys

                                                  select new
                                                  {
                                                      Name = key,
                                                      Value = metadata[key]
                                                  };



                    metadataRepeater.DataBind();

                }
            }

        }

        protected void OnDeleteImage(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string blobName = (string)e.CommandArgument;
                if (this.container.DoesBlobExist(blobName))
                {
                    this.container.DeleteBlob(blobName);
                }
                else
                    this.status.Text = "Item does not exist";
                RefreshGallery();
            }
        }


        public Stream CreateThumbnail(Stream input)
        {
            Bitmap orig = new Bitmap(input);

            int width;
            int height;
            if (orig.Width > orig.Height)
            {
                width = 128;
                height = 128 * orig.Height / orig.Width;
            }
            else
            {
                height = 128;
                width = 128 * orig.Width / orig.Height;
            }

            Bitmap thumb = new Bitmap(width, height);
            using (Graphics graphic = Graphics.FromImage(thumb))
            {
                graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                graphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;

                graphic.DrawImage(orig, 0, 0, width, height);
                MemoryStream ms = new MemoryStream();
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);

                ms.Seek(0, SeekOrigin.Begin);
                return ms;
            }

        }

    }
}
