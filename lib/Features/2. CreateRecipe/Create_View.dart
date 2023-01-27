import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/Colors.dart';

class CreateView extends ConsumerStatefulWidget {
  const CreateView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateViewState();
}

class _CreateViewState extends ConsumerState<CreateView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.03),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Recipe",
                style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height:15),
              Text(
                "Get a recipe based on your ingredients",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: AppColors().grey
                ),
              ),
              const SizedBox(height:15),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No Recipe Found",
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors().primary
                      ),
                    ),
                    Text(
                      "0Kcal",
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:15),
              const Divider(
                height: 2,
                thickness: 3,
                color: Colors.black,
              ),
              const SizedBox(height:15),
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return Container(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No Recipe Found",
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors().primary
                                ),
                              ),
                              Text(
                                "Quantity",
                                style: GoogleFonts.lato(
                                    color: AppColors().grey
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "0Kcal",
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10,);
                  },
                )
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: const Size(409, 53),
                  backgroundColor: AppColors().primary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
                child: const Text('Add Ingredient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
