import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/pdf_assesment_generate/quick_tech_pdf_assesment_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class QuickTechAssesmentPdf extends StatelessWidget {
  final QuickTechPdfAssesmentController pdfController = locator.get<QuickTechPdfAssesmentController>();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(bottomOpacity:4,
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          ),
          title: Text(
            'Assesment',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
        
        ),
      body: FutureBuilder<pw.Document>(
        future: pdfController.generatePDF(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error generating PDF'));
          } else if (snapshot.hasData) {
            return InteractiveViewer(
              boundaryMargin: EdgeInsets.all(0),
              minScale: 0.5,
              maxScale: 4.0,
              child: PdfPreview(
                build: (format) => snapshot.data!.save(),

                canChangeOrientation: true,
                canDebug: false,
              ),
            );
          } else {
            return Center(child: Text('No data available for PDF'));
          }
        },
      ),
    );
  }
}


