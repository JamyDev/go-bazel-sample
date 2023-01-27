package sample

import "fmt"
import "context"
import "google.golang.org/grpc"
import sample "proto/jamy.be/sample"

const _variable = "content"

func main() {
	s := Service{}
	name := "Jamy"

	reply, _ := s.HelloWorld(nil, &sample.HelloRequest{Name: &name})
	fmt.Println(reply.GetMessage())
}

type Service struct{}

func (s Service) HelloWorld(ctx context.Context, in *sample.HelloRequest, opts ...grpc.CallOption) (*sample.HelloReply, error) {
	msg := fmt.Sprintf("Hello %s", in.GetName())
	return &sample.HelloReply{
		Message: &msg,
	}, nil
}
