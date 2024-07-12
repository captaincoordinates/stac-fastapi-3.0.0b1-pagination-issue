from fastapi.responses import ORJSONResponse
from stac_fastapi.api.app import StacApi
from stac_fastapi.api.models import create_get_request_model, create_post_request_model
from stac_fastapi.types.config import ApiSettings
from stac_fastapi.extensions.core import TokenPaginationExtension

from core import CoreCrudClient

extensions=[TokenPaginationExtension()]
post_request_model = create_post_request_model(extensions)

api = StacApi(
    settings=ApiSettings(),
    extensions=extensions,
    client=CoreCrudClient(post_request_model=post_request_model),  # type: ignore
    response_class=ORJSONResponse,
    search_get_request_model=create_get_request_model(extensions),
    search_post_request_model=post_request_model,
    middlewares=[],
)
app = api.app
