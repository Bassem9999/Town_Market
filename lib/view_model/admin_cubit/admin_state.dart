part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitialState extends AdminState {}

class GetImageState extends AdminState {}

class DroplistState extends AdminState {}

class AddProductState extends AdminState {}

class UpdateProductState extends AdminState {}

class DeleteProductState extends AdminState {}

class OrderDeliveredState extends AdminState {}


