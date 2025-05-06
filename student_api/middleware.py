# middleware.py
def reflect_node_id_middleware(get_response):
    def middleware(request):
        response = get_response(request)
        node_id = request.headers.get('X-Node-ID')
        if node_id:
            response['X-Node-ID'] = node_id
        return response
    return middleware
