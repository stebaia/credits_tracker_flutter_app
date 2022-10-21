abstract class DTOMapper<D, M> {
  M toModel(D dto);
  D toTrasnferObject(M model);
}
