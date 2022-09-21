import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';


class SelectGenre extends StatelessWidget {


  List<ModelList> list =[
    ModelList(title: 'for remainder 0',

        dataList: [

          DataList(itemLength: 3),

          DataList(itemLength: 6),

          DataList(itemLength: 9)

        ],

    ),
    ModelList(title: 'for remainder 1',
      dataList: [
        DataList(itemLength: 1),
        DataList(itemLength: 4),
        DataList(itemLength: 7),
      ],

    ),
    ModelList(title: 'for remainder 2',
      dataList: [

        DataList(itemLength: 2),
        DataList(itemLength: 5),
        DataList(itemLength: 8)
      ],

    ),

  ];

 var item = [1,2,3, 4, 5,6,7,8,9];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(

              shrinkWrap: true,
              itemCount: item.length,
              itemBuilder: (context, index){
                return Column(
                  children: [

                    Text("Title"),
                     SizedBox(height: 5,),
                    if(item[index]%3==0)
                      Container(

                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          itemCount: item[index],
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              GenreTile(

                              ),
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.count(
                                  (3 % 3 == 0) ? 1 : 3,
                                  (3 % 3 == 0) ? 1 : 3),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      ),

                    //else if( item[index]%3==2)
                      if(item[index]==8)
                        Container(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 3,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            itemBuilder: (context, index) => GenreTile(

                            ),
                            staggeredTileBuilder: (index) => index==0 ||
                                index==3 || index==4 || index==7  ?StaggeredTile.count(2,1):StaggeredTile.count(1,1),

                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                        ),
                       if(item[index]==5)
                         Container(
                           child: StaggeredGridView.countBuilder(
                             crossAxisCount: 3,
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemCount: 5,
                             itemBuilder: (context, index) => GenreTile(

                             ),
                             staggeredTileBuilder: (index) => StaggeredTile.count(
                                 (index% 8 == 0) ?  2: 1,
                                 (index %  3== 0) ? 1 : 1),
                             mainAxisSpacing: 8.0,
                             crossAxisSpacing: 8.0,
                           ),
                         ),
                    if(item[index]==2)
                      Container(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:2 ,
                          itemBuilder: (context, index) => GenreTile(

                          ),
                          staggeredTileBuilder: (index) => StaggeredTile.count(
                              (index % 2 == 0) ?  2: 1,
                              ( index%  2== 0) ? 1 : 1),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      ),//if (item[index] %3==1)

                            if(item[index]==7)
                              Container(
                                child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  itemCount: 7,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => GenreTile(

                                  ),
                                  staggeredTileBuilder: (index) => index==0 ||
                                      index==3 ?StaggeredTile.count(2,1):StaggeredTile.count(1,1),
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                              ),
                    if (item[index]==4)
                      Container(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) => GenreTile(

                          ),
                          staggeredTileBuilder: (index) => index==0 ||
                              index==3 ?StaggeredTile.count(2,1):StaggeredTile.count(1,1)
                          ,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      ),
                    if(item[index]==1)
                      Container(

                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:1 ,
                          itemBuilder: (context, index) => GenreTile(

                          ),
                          staggeredTileBuilder: (index) => StaggeredTile.count(
                              (index % 3 == 0) ?  1: 3,
                              ( index%  3== 0) ? 1 : 3),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      ),


                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

class GenreTile extends StatelessWidget {
  const GenreTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(MyImgs.mango),
          fit: BoxFit.fill
          )
        ),
      ),
    );
  }
}

 class  ModelList{
   String title;
   List <DataList> dataList;
   ModelList({
     required this.title,
     required this.dataList
 });
 }

 class DataList {
   int itemLength;
   DataList({required this.itemLength});
 }
