import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


Widget customImageView(String imagePath){
  return PhotoViewGallery.builder(
          itemCount: 1,  
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imagePath), 
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(),
        );
}