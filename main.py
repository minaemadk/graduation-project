from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from schemas import DocumentCreate, DocumentResponse
import crud

app = FastAPI(title="DeepVerify API")


@app.get("/")
def read_root():
    return {"message": "FastAPI Server is running successfully!"}


@app.get("/documents", response_model=list[DocumentResponse])
def read_documents(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
):
    return crud.get_documents(db, skip=skip, limit=limit)


@app.get("/documents/{document_id}", response_model=DocumentResponse)
def read_document(
    document_id: int,
    db: Session = Depends(get_db),
):
    document = crud.get_document(db, document_id=document_id)

    if document is None:
        raise HTTPException(status_code=404, detail="Document not found")

    return document


@app.post("/documents", response_model=DocumentResponse, status_code=201)
def create_document(
    document: DocumentCreate,
    db: Session = Depends(get_db),
):
    return crud.create_document(db, document)
