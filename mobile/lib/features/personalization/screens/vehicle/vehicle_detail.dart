import 'package:flutter/material.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text('69E1-626334'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(
                      title: TTexts.type, content: "Trailer Truck"),
                ),
                Expanded(
                  child: TVehicleLine(title: TTexts.brand, content: "Toyota"),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(title: TTexts.model, content: "Corolla"),
                ),
                Expanded(
                  child: TVehicleLine(title: TTexts.year, content: "2020"),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(title: TTexts.color, content: "White"),
                ),
                Expanded(
                  child:
                      TVehicleLine(title: TTexts.plate, content: "69E1-626334"),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style:
                        OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems,
                ),
                Expanded(
                    child:
                        ElevatedButton(onPressed: () {}, child: const Text('Edit'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TVehicleLine extends StatelessWidget {
  const TVehicleLine({
    super.key,
    required this.title,
    required this.content,
  });

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w600)
                .apply(color: Colors.blueGrey)),
        const SizedBox(
          height: TSizes.spacebtwItems * 0.3,
        ),
        Text(content, style: Theme.of(context).textTheme.titleMedium)
      ],
    );
  }
}
