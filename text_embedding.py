import sklearn
import torch
import torch_npu

from langchain_community.embeddings import HuggingFaceEmbeddings
from fastapi import FastAPI
from pydantic import BaseModel

device = "npu"


class RequestData(BaseModel):
    text: str


embeddings = HuggingFaceEmbeddings(
    model_name="model/",
    encode_kwargs={'normalize_embeddings': True},
    model_kwargs={"device": device},
)
app = FastAPI()


@app.post("/text_embedding")
async def text_embedding(request_data: RequestData):
    if len(request_data.text.strip()) == 0:
        return {'error': 'empty input'}

    query_result = embeddings.embed_query(request_data.text)
    return {'embedding': query_result}